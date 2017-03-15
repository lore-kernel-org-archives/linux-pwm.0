From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2
Date: Wed, 15 Mar 2017 14:37:39 -0500
Message-ID: <20170315193739.cebry3tafla5zz5v@rob-hp-laptop>
References: <1488468525-28726-1-git-send-email-claudiu.beznea@microchip.com>
 <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32774 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOThm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Mar 2017 15:37:42 -0400
Content-Disposition: inline
In-Reply-To: <1488468525-28726-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Mar 02, 2017 at 05:28:45PM +0200, Claudiu Beznea wrote:
> sama5d2 can use the same atmel_pwm_data as sama5d3.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> ---
>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>  drivers/pwm/pwm-atmel.c                             | 3 +++
>  2 files changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
