From: Paul Barker <pbarker@konsulko.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 13:34:50 +0000
Message-ID: <20200317133450.58c25bcb@ub1910>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCQNey (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:34:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so9285136wrv.13
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2020 06:34:53 -0700 (PDT)
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nicolas Ferre <nicolas.ferre@microchip.>

On Tue, 17 Mar 2020 14:32:25 +0200
Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:

> The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> Rename it to PWM_POLARITY_INVERTED.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Looks good. PWM_POLARITY_INVERSED confused me when I was working in this area
recently. After applying to master there's no more instances of
PWM_POLARITY_INVERSED in the source tree.

Reviewed-by: Paul Barker <pbarker@konsulko.com>

-- 
Paul Barker
Konsulko Group
