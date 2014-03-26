From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 0/2] pwm-backlight: switch to gpiod interface (part 1)
Date: Wed, 26 Mar 2014 14:01:21 +0900
Message-ID: <CAAVeFuKE163O3Kcdy-WCCEesJMCQ-fcLe8Op5f=VE7ZovFptqA@mail.gmail.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44633 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaCZFBm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Mar 2014 01:01:42 -0400
In-Reply-To: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Ping Thierry, can you have a look at this series? It is quite similar
to the same change you merged for panel-simple (although I cannot see
it in -next neither).

On Thu, Feb 27, 2014 at 2:53 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> These two patches initiate the switch of the pwm-backlight driver to
> the gpiod GPIO interface, as it considerably simplifies the code.
>
> For compatibility with current users of the driver, it is still possible
> to pass the enable GPIO number as platform data. Two platforms are still
> relying on this feature (pxa/palmtc and shmobile/armadillo800eva) which
> will be removed as soon as its last users are switched to GPIO mapping
> tables.
>
> Alexandre Courbot (2):
>   ARM: SAMSUNG: remove gpio flags in dev-backlight
>   pwm-backlight: switch to gpiod interface
>
>  arch/arm/plat-samsung/dev-backlight.c |  2 -
>  drivers/video/backlight/pwm_bl.c      | 72 +++++++++++++++--------------------
>  include/linux/pwm_backlight.h         |  5 +--
>  3 files changed, 32 insertions(+), 47 deletions(-)
>
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
