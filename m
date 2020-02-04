From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
Date: Tue, 4 Feb 2020 07:46:51 +0100
Message-ID: <20200204064651.jaxyftjj346xrdml@pengutronix.de>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200203213536.32226-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Bart Tanghe <bart.tanghe@thomasmore.be>, Stephen Warren <swarren@wwwdotorg.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hallo Florian,

On Mon, Feb 03, 2020 at 01:35:35PM -0800, Florian Fainelli wrote:
> The newer 2711 and 7211 chips have two PWM controllers and failure to
> dynamically allocate the PWM base would prevent the second PWM
> controller instance being probed for succeeding with an -EEXIST error
> from alloc_pwms().
> 
> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
