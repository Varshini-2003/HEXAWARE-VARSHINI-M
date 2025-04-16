import unittest
from dao.loan_repository_impl import LoanRepositoryImpl


class TestLoanCalculations(unittest.TestCase):

    def test_interest_calculation(self):
        repo = LoanRepositoryImpl()
        interest = repo.calculate_interest_by_params(100000, 10, 12)
        self.assertEqual(interest, 10000.0)

    def test_emi_calculation(self):
        repo = LoanRepositoryImpl()
        emi = repo.calculate_emi_by_params(100000, 12, 12)
        self.assertTrue(emi > 0)
        
   
    

if __name__ == '__main__':
    unittest.main()
