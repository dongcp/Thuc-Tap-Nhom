using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTranferObject
{
    public class Food
    {
        public string ID { get; set; }

        private string name;
        private string group;
        private string type;
        private string unit;
        private double price;

        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                if (value != "")
                    name = value;
                else
                    throw new Exception("Chưa nhập tên món ăn!");
            }
        }

        public string Group
        {
            get
            {
                return group;
            }
            set
            {
                if (value != "")
                    group = value;
                else
                    throw new Exception("Chưa nhập nhóm!");
            }
        }

        public string Type
        {
            get
            {
                return type;
            }
            set
            {
                if (value != "")
                    type = value;
                else
                    throw new Exception("Chưa nhập loại!");
            }
        }

        public string Unit
        {
            get
            {
                return unit;
            }
            set
            {
                if (value != "")
                    unit = value;
                else
                    throw new Exception("Chưa nhập đơn vị!");
            }
        }

        public double Price
        {
            get
            {
                return price;
            }
            set
            {
                if (value > 0)
                    price = value;
                else
                    throw new Exception("Giá tiền không hợp lệ!");
            }
        }

        public Food()
        {
            ID = "Unknow";
            name = "Unknow";
            group = "Unknown";
            type = "Unknown";
            unit = "Unknown";
            price = 1;
        }

        public Food(string id, string name, string group, string type, string unit, double price)
        {
            this.ID = id;
            this.name = name;
            this.group = group;
            this.type = type;
            this.unit = unit;
            this.price = price;
        }
    }
}
