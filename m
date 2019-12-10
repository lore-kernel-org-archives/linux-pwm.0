From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
Date: Tue, 10 Dec 2019 07:52:29 +0100
Message-ID: <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
References: <20191209232503.7252-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191209232503.7252-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net, Thierry Reding <thierry.reding@gmail.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 09, 2019 at 03:25:03PM -0800, Florian Fainelli wrote:
> BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
> driver, make it possible to build it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index bd21655c37a6..0bb8a40c8d6c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -100,7 +100,7 @@ config PWM_BCM_KONA
>  
>  config PWM_BCM2835
>  	tristate "BCM2835 PWM support"
> -	depends on ARCH_BCM2835
> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB

It would be nice to allow this driver to be compiled with COMPILE_TEST,
too. But also without this:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
