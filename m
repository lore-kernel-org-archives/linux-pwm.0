Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:55478 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeLIWsT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Dec 2018 17:48:19 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 10 Dec 2018 00:48:58 +0200
Message-ID: <1983308.yQfnePZf9b@avalon>
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 0/5] pwm: rcar: Add support "atomic" API and workaround
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Shimoda-san,

Thank you for the patches.

On Friday, 7 December 2018 10:29:28 EET Yoshihiro Shimoda wrote:
> This patch adds support for PWM "atomic" API.
> 
> This patch also adds a workaround to output "pseudo" low level.
> Otherwise, the PWM backlight driver doesn't work correctly, especially
> it cannot output maximum brightness actually.
> 
> Yoshihiro Shimoda (5):
>   pwm: rcar: add rcar_pwm_calc_counter() to calculate PWMCNT value only
>   pwm: rcar: Add support "atomic" API
>   pwm: rcar: Use "atomic" API on rcar_pwm_resume()
>   pwm: rcar: remove legacy APIs
>   pwm: rcar: add workaround to output "pseudo" low level
> 
>  drivers/pwm/pwm-rcar.c | 108 ++++++++++++++++++++++++++--------------------
>  1 file changed, 62 insertions(+), 46 deletions(-)

For the whole series,

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

with backlight on the Draak board.

I do however agree with Uwe's comments.

-- 
Regards,

Laurent Pinchart
