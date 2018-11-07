From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Wed, 7 Nov 2018 17:12:47 +0100
Message-ID: <20181107161247.sesu2comhes2d4kx@pengutronix.de>
References: <20181107093613.26734-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107093613.26734-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 07, 2018 at 10:36:12AM +0100, Clément Péron wrote:
> The Cygnus architecture use a Kona PWM. This is already present
> in the device tree but can't be built actually. Hence, allow the
> Kona PWM to be built for Cygnus arch.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 763ee50ea57d..76d56fc8b1b7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
>  
>  config PWM_BCM_KONA
>  	tristate "Kona PWM support"
> -	depends on ARCH_BCM_MOBILE
> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> +	default ARCH_BCM_CYGNUS

Is it possible to build this driver also on other arches? Then you might
want to consider

	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
