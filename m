From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
Date: Wed, 23 Jan 2019 10:01:55 -0800
Message-ID: <20190123180155.GB9781@roeck-us.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-6-paul@crapouillou.net>
 <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
 <128675a5-7ede-4114-a649-89a536346dc8@roeck-us.net>
 <1548264353.3173.1@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548264353.3173.1@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mathieu Malaterre <malat@debian.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me, Maar
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 23, 2019 at 02:25:53PM -0300, Paul Cercueil wrote:
> Hi,
> 
> Le mer. 23 janv. 2019 à 11:31, Guenter Roeck <linux@roeck-us.net> a écrit :
> >On 1/23/19 4:58 AM, Mathieu Malaterre wrote:
> >>On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>
> >>wrote:
> >>>
> >>>From: Maarten ter Huurne <maarten@treewalker.org>
> >>>
> >>>OST is the OS Timer, a 64-bit timer/counter with buffered reading.
> >>>
> >>>SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> >>>JZ4780 have a 64-bit OST.
> >>>
> >>>This driver will register both a clocksource and a sched_clock to the
> >>>system.
> >>>
> >>>Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> >>>Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>>---
> >>>
> >>>Notes:
> >>>      v5: New patch
> >>>
> >>>      v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info
> >>>as
> >>>            devicetree match data instead.
> >>>          - Use device_get_match_data() instead of the of_* variant
> >>>          - Handle error of dev_get_regmap() properly
> >>>
> >>>      v7: Fix section mismatch by using
> >>>builtin_platform_driver_probe()
> >>>
> >>>      v8: builtin_platform_driver_probe() does not work anymore in
> >>>          4.20-rc6? The probe function won't be called. Work around
> >>>this
> >>>          for now by using late_initcall.
> >>>
> >
> >Did anyone notice this ? Either something is wrong with the driver, or
> >with the kernel core. Hacking around it seems like the worst possible
> >"solution".
> 
> I can confirm it still happens on 5.0-rc3.
> 
> Just to explain what I'm doing:
> 
> My ingenic-timer driver probes with builtin_platform_driver_probe (this
> works),
> and then calls of_platform_populate to probe its children. This driver,
> ingenic-ost, is one of them, and will fail to probe with
> builtin_platform_driver_probe.
> 

The big question is _why_ it fails to probe.

Guenter
