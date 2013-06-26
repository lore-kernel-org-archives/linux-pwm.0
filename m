Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130626094604.GA9794@mithrandir>
References: <CAPgLHd8g2ChKSfyGUkFWBB-Z_6At2awyMAMRvA1fTvmCmeea+g@mail.gmail.com>
	<20130626094604.GA9794@mithrandir>
Date: Wed, 26 Jun 2013 17:56:06 +0800
Message-ID: <CAPgLHd-sn=j_eStYTp6C7zJbB33-oXpnnm8K7J-zXn2Sdf7kFQ@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: samsung: fix return value check in pwm_samsung_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, yongjun_wei@trendmicro.com.cn, kgene.kim@samsung.com, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 06/26/2013 05:46 PM, Thierry Reding wrote:
> On Wed, Jun 26, 2013 at 06:55:18AM +0800, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check should
>> be replaced with IS_ERR().
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  drivers/pwm/pwm-samsung.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> Missed another one of those. Given that this isn't merged yet, would you
> mind if Tomasz and/or Kukjin squash it into their patch?

It's OK to me.
