Return-Path: <kgene.kim@gmail.com>
Return-Path: <kgene.kim@gmail.com>
Sender: Kukjin Kim <kgene.kim@gmail.com>
Message-ID: <51BE23FD.8030403@samsung.com>
Date: Mon, 17 Jun 2013 05:45:49 +0900
From: Kukjin Kim <kgene.kim@samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com> <1395589.x1LsEiFKi9@flatron>
In-Reply-To: <1395589.x1LsEiFKi9@flatron>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On 06/17/13 02:19, Tomasz Figa wrote:
> Hi Kukjin,
>
> On Wednesday 05 of June 2013 23:18:13 Tomasz Figa wrote:
>> This patch introduces new Samsung PWM driver, which uses Samsung
>> PWM/timer master driver to control shared parts of the hardware.
>>
>> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
>> ---
>>   drivers/pwm/Makefile      |   1 +
>>   drivers/pwm/pwm-samsung.c | 528
>> ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 529
>> insertions(+)
>>   create mode 100644 drivers/pwm/pwm-samsung.c
>
> I you haven't yet merged this patch, please let me send v2 of this series,
> addressing Heiko's comments and adjustments to my understanding of the PWM
> hardware after getting access to SMDK6410 board, which uses PWM to control
> LCD backlight.
>
Sure, let me hold on until getting your updated series.

Thanks,
- Kukjin
