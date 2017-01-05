From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 6/6] [media] Only descend into directory when
 CONFIG_MEDIA_SUPPORT is set
Date: Thu, 5 Jan 2017 16:35:33 -0600
Message-ID: <f29ea3de-efb1-a406-db3e-b048e677f3a8@ti.com>
References: <20170105210158.14204-1-afd@ti.com>
 <20170105210158.14204-7-afd@ti.com> <4225650.R96pl5clWf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4225650.R96pl5clWf@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pwm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 01/05/2017 03:42 PM, Arnd Bergmann wrote:
> On Thursday, January 5, 2017 3:01:58 PM CET Andrew F. Davis wrote:
>> @@ -109,7 +109,8 @@ obj-$(CONFIG_SERIO)         += input/serio/
>>  obj-$(CONFIG_GAMEPORT)         += input/gameport/
>>  obj-$(CONFIG_INPUT)            += input/
>>  obj-$(CONFIG_RTC_LIB)          += rtc/
>> -obj-y                          += i2c/ media/
>> +obj-y                          += i2c/
>> +obj-$(CONFIG_MEDIA_SUPPORT)    += media/
>>  obj-$(CONFIG_PPS)              += pps/
>>  obj-y                          += ptp/
>>  obj-$(CONFIG_W1)               += w1/
>>
> 
> This one seems wrong: if CONFIG_MEDIA_SUPPORT=m, but some I2C drivers
> inside of drivers/media/ are built-in, we will fail to enter the directory,
> see drivers/media/Makefile.

Not sure if I see this, it looks like everything in drivers/media/
depends on CONFIG_MEDIA_SUPPORT (directly or indirectly). If
CONFIG_MEDIA_SUPPORT is =m then all dependents should be locked out of
being built-in.

Any bool symbol that controls compilation of source that depends on a
tristate symbol is broken and should be fixed anyway.

> 
> I checked the other five patches in the series as well, they all look
> ok to me.
> 
> 	Arnd
> 
