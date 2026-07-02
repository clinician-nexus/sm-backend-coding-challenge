using Dapper;
using System.Collections.Generic;
using System.Data;
using Microsoft.Data.Sqlite;
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
            _connectionString = configuration.GetConnectionString("DefaultConnection")!;
        }

        public async Task<IEnumerable<Fruit>> GetAllFruitsAsync()
        {
            using (IDbConnection connection = new SqliteConnection(_connectionString))
            {
                // TODO: Replace this mock data with real data from the Fruits table (see schema.sql)
                // Dapper is available, and the pre-seeded SQLite database (FruitsDB.db) is ready to query.
                return new List<Fruit> {
                    new Fruit { Id=1, Name="Apple", Color="Red" },
                    new Fruit { Id=2, Name="Banana", Color="Yellow" },
                };
            }
        }
    }
}