import React from 'react';
import { useNavigate } from 'react-router-dom';

const Files: React.FC = () => {
  const navigate = useNavigate();

  const records = [
    {
      month: '2023年10月',
      count: 2,
      items: [
        {
          id: '1',
          title: '胸部CT扫描',
          date: '2023-10-15 14:30',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVdwBoyCPV_JDQvKinPkxoDz4xvyokALWlaZphlVjMDuvrT40g_6Mku6K1XVz6Iv_PP4g78AYKaZLzy7H7LkPN-SVqJDL1StSQNcXU7LwzF9Hyg9vNti2qhkp0Vt7cVxEJNS7h8j6mET5pbkwI-A_Zzky6AZJrfnFj-BbJ5qf0nxSPUvPr8CWS7R8tyrrZCMNCzmaTmVtNiM20XqgAeVuRstRe-55X_gyncW8p-LsPFa95DXxE64ilNrYDMsoDtztEEGYdN1-tbXo',
          status: '建议随访',
          statusType: 'warning',
          icon: 'warning'
        },
        {
          id: '2',
          title: '左手X光片',
          date: '2023-10-02 09:15',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDuqBd7_uI3bbB5MGDnhLwCtN8ZygO_3WRFjK4v70VQ1oZpWuD6k0guqJi-Iwpv93-YeQcDcExmBwvXD2mT4t3zWzZEzRMiOdB8gDVWk0jj9kuGOAEmlKL3G-z4ShKY4VEOGSjGKVJyXHn9pjl6YdwJb-OG0VkyLIe51rIsvyUd4kGWineks2uAKagBt6gNFi555dUCDrnXPXRHBjQpUFi_m8UFhz4RuKtPpEkvXzCIKQeqoULkd3QMLcrDvytljr_93Vb5WIn6RqA',
          status: '未见异常',
          statusType: 'success',
          icon: 'check_circle'
        }
      ]
    },
    {
      month: '2023年08月',
      count: 1,
      items: [
        {
          id: '3',
          title: '头部MRI检查',
          date: '2023-08-20 11:00',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBB47UCeq6FYo1ztE9eL3ZM4nVNiowUdKrjMyOZz-ayRzHy4OYPTPhb3Vq_x561VNvbAuGkStil42y1Sku4qpWFU1rJSMZNR29K4TTo4T9r9bDbPvuIaltSwk9QsiMsXH4itsK8O6zyVRS8lb8eQ-B2rYA32DUZMmhRDmgjHWbxrZ3odRqOCIn904_F2LTQvsYyRuH7dXDP3_ygxRlxcUv3yKDY00tRLtzrKBdR2FgbNHATw8Pw2XjSE-IG9kmtiwAQ55W3lqE4V8A',
          status: '未见异常',
          statusType: 'success',
          icon: 'check_circle'
        }
      ]
    },
    {
      month: '2022年12月',
      count: 1,
      items: [
        {
          id: '4',
          title: '腹部超声波',
          date: '2022-12-05 08:45',
          image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAEXvyZy52-Xfs6pXL2cVwBFlfgExHvSNhiKTOx4ZIUBhH93UeR6nhbdVNzc5CFW1Tf9kP9LnC__su1i4K2qCG6MLrNzOP_lSZQeG9hQnhJTl4TJREOAYvP8JKhTCYBb40AE5AH0muDBXQPdXH1JLx8eEt-Ng55uN3wWDrwjUUvJlX2O3nHYeU5OIEYQJNKwmVoXOWTPE5FGysHwPkHT90QYGKc2y4NSL6Ct0koMB0oftCkinWJFlYPYg7lQYdgoi3R6n0jnodjYjY',
          status: 'AI分析中',
          statusType: 'neutral',
          icon: 'hourglass_empty'
        }
      ]
    }
  ];

  return (
    <div className="flex flex-col min-h-screen bg-background">
      {/* Header */}
      <header className="bg-white px-5 pt-4 pb-4 shadow-sm sticky top-0 z-20">
        <div className="flex items-center justify-between mb-4">
          <button onClick={() => navigate(-1)} className="flex h-10 w-10 items-center justify-center rounded-full text-slate-600 hover:bg-slate-50">
            <span className="material-symbols-outlined">arrow_back</span>
          </button>
          <h1 className="text-lg font-bold text-slate-900">我的健康档案</h1>
          <div className="w-10"></div>
        </div>
        <div className="relative w-full">
          <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <span className="material-symbols-outlined text-slate-400 text-[20px]">search</span>
          </div>
          <input 
            className="block w-full rounded-xl border-none bg-slate-100 py-3 pl-10 pr-4 text-sm text-slate-900 placeholder-slate-400 focus:ring-2 focus:ring-primary focus:bg-white transition-all shadow-sm" 
            placeholder="搜索历史影像报告" 
            type="text"
          />
        </div>
      </header>

      {/* Content */}
      <main className="flex-1 px-5 py-6 space-y-6">
        {records.map((section, idx) => (
          <section key={idx}>
            <div className="flex items-center justify-between mb-3 px-1">
              <h3 className="text-sm font-bold text-slate-500">{section.month}</h3>
              <span className="text-xs font-medium text-slate-400">{section.count} 份报告</span>
            </div>
            <div className="flex flex-col gap-3">
              {section.items.map((item) => (
                <div 
                  key={item.id} 
                  onClick={() => navigate(`/report/${item.id}`)}
                  className="group relative flex items-center gap-4 rounded-xl bg-white p-3 shadow-card hover:shadow-md transition-all active:scale-[0.99] cursor-pointer border border-transparent hover:border-primary/10"
                >
                  <div className="relative h-20 w-20 shrink-0 overflow-hidden rounded-lg bg-slate-200">
                    <div className="absolute inset-0 bg-cover bg-center opacity-90" style={{ backgroundImage: `url('${item.image}')` }}></div>
                  </div>
                  
                  <div className="flex flex-1 flex-col justify-center gap-1">
                    <h4 className="font-bold text-slate-900 text-[15px] leading-tight">{item.title}</h4>
                    <p className="text-xs text-slate-500">{item.date}</p>
                    
                    <div className="mt-1 flex">
                      <span className={`inline-flex items-center rounded-md px-2 py-1 text-xs font-medium border ${
                        item.statusType === 'warning' ? 'bg-orange-50 text-orange-600 border-orange-100' :
                        item.statusType === 'success' ? 'bg-emerald-50 text-emerald-600 border-emerald-100' :
                        'bg-slate-100 text-slate-600 border-slate-200'
                      }`}>
                        <span className="material-symbols-outlined text-[14px] mr-1">{item.icon}</span>
                        {item.status}
                      </span>
                    </div>
                  </div>
                  
                  <div className="pr-1 text-slate-300 group-hover:text-primary transition-colors">
                    <span className="material-symbols-outlined">chevron_right</span>
                  </div>
                </div>
              ))}
            </div>
          </section>
        ))}
      </main>
      
      {/* Floating Action Button */}
      <button className="fixed bottom-24 right-5 h-14 w-14 rounded-full bg-primary shadow-float flex items-center justify-center text-white active:scale-95 transition-transform z-30">
        <span className="material-symbols-outlined text-[28px]">add_photo_alternate</span>
      </button>
    </div>
  );
};

export default Files;