From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Date: Wed, 23 Jan 2019 06:31:57 -0800
Message-ID: <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-6-paul@crapouillou.net>
 <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>, Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me, Maarten ter Huurne <maarten@treewalker.org>
List-Id: linux-pwm@vger.kernel.org

On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net> wrote:
>>
>> From: Maarten ter Huurne <maarten@treewalker.org>
>>
>> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>
>> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>> JZ4780 have a 64-bit OST.
>>
>> This driver will register both a clocksource and a sched_clock to the
>> system.
>>
>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>
>> Notes:
>>       v5: New patch
>>
>>       v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info as
>>             devicetree match data instead.
>>           - Use device_get_match_data() instead of the of_* variant
>>           - Handle error of dev_get_regmap() properly
>>
>>       v7: Fix section mismatch by using builtin_platform_driver_probe()
>>
>>       v8: builtin_platform_driver_probe() does not work anymore in
>>           4.20-rc6? The probe function won't be called. Work around this
>>           for now by using late_initcall.
>>

Did anyone notice this ? Either something is wrong with the driver, or
with the kernel core. Hacking around it seems like the worst possible
"solution".

Guenter
