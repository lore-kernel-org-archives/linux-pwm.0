From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 4/10] pwm: mediatek: use pwm_mediatek as common prefix
Date: Tue, 20 Aug 2019 07:55:36 +0200
Message-ID: <20190820055536.xode62n3gk37ikqv@pengutronix.de>
References: <1566265225-27452-1-git-send-email-sam.shih@mediatek.com>
 <1566265225-27452-5-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566265225-27452-5-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 20, 2019 at 09:40:19AM +0800, Sam Shih wrote:
> From: sam shih <sam.shih@mediatek.com>
> 
> Use pwm_mediatek as common prefix to match the filename.
> No functional change intended.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 117 ++++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index a70b69a975c1..d85761ad5283 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -1,12 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Mediatek Pulse Width Modulator driver
> + * MediaTek Pulse Width Modulator driver
>   *
>   * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
>   * Copyright (C) 2017 Zhi Mao <zhi.mao@mediatek.com>
>   *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.

The license stuff is a separate change.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
