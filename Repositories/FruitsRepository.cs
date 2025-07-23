using Dapper;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using CodingChallenge.Interfaces;
using CodingChallenge.Models;

namespace CodingChallenge.Repositories
{
    public class FruitsRepository : IFruitsRepository
    {
        private readonly string _connectionString;

        public FruitsRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<IEnumerable<Fruit>> GetAllFruitsAsync()
        {
            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                // TODO: Replace this mock data iwth real data from the Fruits table (see schema.sql)
                // Dapper is available, db connection should work
                // as long as you've run `make db-init`
                return new List<Fruit> {
                    new Fruit { Id=1, Name="Apple", Color="Red" },
                    new Fruit { Id=2, Name="Banana", Color="Yellow" },
                };
            }
        }
    }
}