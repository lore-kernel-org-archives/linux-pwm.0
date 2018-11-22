From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Thu, 22 Nov 2018 21:05:36 +0100
Message-ID: <20181122200536.ndgrxuxealtovngy@pengutronix.de>
References: <20181121123508.25119-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121123508.25119-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Clément,

On Wed, Nov 21, 2018 at 01:35:08PM +0100, Clément Péron wrote:
> The Cygnus architecture use a Kona PWM. This is already present
> in the device tree but can't be built actually. Hence, allow the
> Kona PWM to be built for Cygnus arch.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 27e5dd47a01f..982f4059f4e8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -88,7 +88,9 @@ config PWM_BCM_IPROC
>  
>  config PWM_BCM_KONA
>  	tristate "Kona PWM support"
> -	depends on ARCH_BCM_MOBILE
> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	default ARCH_BCM_CYGNUS

This looks good. As pointed out before the default is a bit strange
and could include ARCH_BCM_MOBILE for symmetry.

Anyhow:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Related to this driver I have a set of questions: If the disable
callback completed, does the hardware still drive the pin? If yes, would
it be possible to disable the pin driver such that the pin gets high-Z?
If yes, how?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
