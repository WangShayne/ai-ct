import React from 'react';
import { useNavigate } from 'react-router-dom';

const Home: React.FC = () => {
  const navigate = useNavigate();

  const recentRecords = [
    {
      id: '48291',
      title: '胸部 CT 检测报告',
      desc: 'AI 深度分析 • 肺部影像',
      time: '10 分钟前',
      status: '已生成',
      statusColor: 'text-green-600 bg-green-50',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCE1pPA9AwYpUrLPUpMzfFjA1eG4bG1BmA5_69qnqlfvtV_JWHGYpQXRYGabIqfZE1jwDSU-X33hQwVnNinMOa7MbGypbAvUjcU7t6oRkZof6v-o0BlkIGos8VZFdwRViYLPSYfl5NVt8-XxFeUFRNUzHsNNHUvGE4qCF33vmcy-MZM7aaNVQq4uiqprNXoqAOTV7hnkOGNUTSD-lSsJ9RSd_mipxncaNgSy8J3QUrKI0IOYLGVf5YlGUiUWdP8o90AwfjKctlbSqU'
    },
    {
      id: 'processing',
      title: '头部 CT 影像',
      desc: '正在进行 AI 运算...',
      time: '2 小时前',
      status: '分析中',
      statusColor: 'text-amber-600 bg-amber-50',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC6_vhFufvz-BYhyqnY381hxddcGyr7uo7b9Y1JfGbYHSfDHwOIDbxIYVjsqV215zrMDDcTxzqBdaJjUNoqnGYdAKdw_2j_pF1lup5ZylQ2JWS8Tm8X3c-NskP-26KWbgT3ElZVBXelDp4WPlSnkElhh2tJCZIhP5uc6hSra6Sh72h_mHgyg5mpQNqACa6b3KW0sj7ge106LUnL0TEap3AJcefCXkmn2aCGHEX9aLWsdMJotT5U8IVOLymT-EqxPMwSuw_ULnumzOw'
    },
    {
      id: 'normal',
      title: '腹部常规检查',
      desc: '无明显异常发现',
      time: '昨天',
      status: '已生成',
      statusColor: 'text-green-600 bg-green-50',
      isIcon: true
    }
  ];

  return (
    <div className="flex flex-col min-h-screen pb-24">
      {/* Header */}
      <header className="sticky top-0 z-30 bg-white/90 backdrop-blur-md border-b border-gray-100">
        <div className="flex items-center justify-between p-4">
          <div className="flex items-center gap-3">
            <div className="bg-center bg-no-repeat bg-cover rounded-full size-10 ring-2 ring-primary/20" 
                 style={{ backgroundImage: 'url("https://lh3.googleusercontent.com/aida-public/AB6AXuC33gh9r-8-pxjOXB1uN9xTy7RcOrZgQavPv2LY5DJj6PCE--fJMiO34VxV7Rv4X2IPI8fiZoUoUkV9lRsTtsCNnCuYSNT4BQHADLv6GxSbseV07zo-fBYT8LuIvtEpQWJ0DEZjjfCYF2I_e0arMsJUngaD0uJ4eP6-tZd8iJA8PsWeYMIRbtlua9rpkWoIjxVYV26_-Y9LjGyDw-pw4Y37pkfMfam_DPw7w0wpbBLHZH6P1nRnBr-XFUVvTzoZQW3e0RoXE0JdgEs")' }}>
            </div>
            <div className="flex flex-col">
              <span className="text-xs font-medium text-gray-500">个人中心</span>
              <h2 className="text-sm font-bold leading-tight">张伟</h2>
            </div>
          </div>
          <button 
            onClick={() => navigate('/notifications')}
            className="flex items-center justify-center size-10 rounded-full bg-gray-50 text-gray-600 hover:bg-gray-100 transition-colors relative">
            <span className="material-symbols-outlined">notifications</span>
            <span className="absolute top-2 right-2 size-2 bg-red-500 rounded-full border border-white"></span>
          </button>
        </div>
      </header>

      <main className="flex-1 w-full px-4 pt-6">
        {/* Hero Section */}
        <section className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900 mb-1">您好，张伟</h1>
          <p className="text-gray-500 text-sm mb-6">上传您的影像资料，获取AI健康解析。</p>
          
          <div className="bg-white rounded-2xl p-5 shadow-card border border-gray-100">
            <div className="flex flex-col gap-4">
              <button className="w-full bg-primary hover:bg-primary-dark text-white rounded-xl h-14 flex items-center justify-center gap-3 font-semibold text-lg shadow-float transition-all active:scale-[0.98]">
                <span className="material-symbols-outlined">smart_toy</span>
                开始AI分析
              </button>
              
              <div className="relative flex py-1 items-center">
                <div className="flex-grow border-t border-gray-100"></div>
                <span className="flex-shrink-0 mx-4 text-gray-400 text-xs uppercase font-medium">其他方式</span>
                <div className="flex-grow border-t border-gray-100"></div>
              </div>
              
              <div className="grid grid-cols-2 gap-3">
                <button className="flex flex-col items-center justify-center gap-2 h-24 rounded-xl bg-gray-50 hover:bg-gray-100 text-primary transition-colors border border-transparent hover:border-primary/20">
                  <span className="material-symbols-outlined text-3xl">photo_camera</span>
                  <span className="text-sm font-medium text-gray-700">拍照上传</span>
                </button>
                <button className="flex flex-col items-center justify-center gap-2 h-24 rounded-xl bg-gray-50 hover:bg-gray-100 text-primary transition-colors border border-transparent hover:border-primary/20">
                  <span className="material-symbols-outlined text-3xl">add_photo_alternate</span>
                  <span className="text-sm font-medium text-gray-700">从相册选择</span>
                </button>
              </div>
            </div>
          </div>
        </section>

        {/* Recent Records */}
        <section>
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-bold text-gray-900">最近记录</h3>
            <button onClick={() => navigate('/files')} className="text-sm font-medium text-primary hover:text-primary-dark">查看全部</button>
          </div>
          
          <div className="flex flex-col gap-3">
            {recentRecords.map((record) => (
              <div 
                key={record.id}
                onClick={() => record.id !== 'processing' ? navigate(`/report/${record.id}`) : null}
                className="flex items-center p-3 bg-white rounded-xl shadow-card border border-gray-50 hover:border-primary/30 transition-all cursor-pointer active:scale-[0.99]"
              >
                {record.isIcon ? (
                   <div className="size-14 rounded-lg bg-gray-100 flex items-center justify-center text-gray-400">
                     <span className="material-symbols-outlined text-[28px]">health_metrics</span>
                   </div>
                ) : (
                  <div className="size-14 rounded-lg bg-gray-200 bg-center bg-cover flex-shrink-0" 
                       style={{ backgroundImage: `url("${record.image}")` }}>
                  </div>
                )}
                
                <div className="ml-3 flex-1 min-w-0">
                  <div className="flex justify-between items-start">
                    <h4 className="text-sm font-bold text-gray-900 truncate">{record.title}</h4>
                    <span className={`text-[10px] font-medium px-2 py-0.5 rounded-full ${record.statusColor}`}>
                      {record.status}
                    </span>
                  </div>
                  <p className="text-xs text-gray-500 mt-1">{record.desc}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{record.time}</p>
                </div>
                
                <div className="ml-2 text-gray-300">
                  <span className="material-symbols-outlined">chevron_right</span>
                </div>
              </div>
            ))}
          </div>
        </section>
      </main>
    </div>
  );
};

export default Home;