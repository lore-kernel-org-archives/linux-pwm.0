From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] hwmon: pwm-fan: switch to new atomic PWM API
Date: Mon, 24 Apr 2017 16:25:56 +0200
Message-ID: <1767160.ko02kahecW@amdc3058>
References: <CGME20170424131342epcas5p4cb2f53f6c780119557ff3da56fb8f0a8@epcas5p4.samsung.com>
 <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
 <6c741041-faf4-6951-5f2d-9f7b9c54c9ca@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-reply-to: <6c741041-faf4-6951-5f2d-9f7b9c54c9ca@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


Hi,

On Monday, April 24, 2017 06:26:12 AM Guenter Roeck wrote:
> On 04/24/2017 06:13 AM, Bartlomiej Zolnierkiewicz wrote:
> > Switch pwm-fan driver to new atomic PWM API.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > Depends on "[PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support"
> > patchset (https://www.spinics.net/lists/kernel/msg2495209.html).
> >
> 
> Why would this driver, which does not depend on any Samsung code,
> depend on a Samsung specific fix ?

The above patchset contains pwm-fan specific patch:
"[PATCH v2 3/3] hwmon: pwm-fan: remove no longer needed suspend/resume code"
(https://www.spinics.net/lists/kernel/msg2495210.html).

It seems that the patchset name itself could be better,
sorry for this.

> Was this tested with hardware ?

Yes, on Exynos5422 based Odroid-XU3 board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

