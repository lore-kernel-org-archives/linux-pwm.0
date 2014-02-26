From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] pwm,renesas-tpu: Add dependency on HAS_IOMEM
Date: Wed, 26 Feb 2014 12:59:57 +0100
Message-ID: <530DD73D.3020507@nod.at>
References: <1391172318-17853-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391172318-17853-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-Id: linux-pwm@vger.kernel.org

Am 31.01.2014 13:45, schrieb Richard Weinberger:
> On archs like S390 or um this driver cannot build nor work.
> Make it depend on HAS_IOMEM to bypass build failures.
> 
> drivers/built-in.o: In function `tpu_probe':
> drivers/pwm/pwm-renesas-tpu.c:421: undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Ping?

Thanks,
//richard

> ---
>  drivers/pwm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 22f2f28..0b7a3c9 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -160,6 +160,7 @@ config PWM_PXA
>  config PWM_RENESAS_TPU
>  	tristate "Renesas TPU PWM support"
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	help
>  	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
>  	  in Renesas chips through the PWM API.
> 
