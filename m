From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas-tpu: Document more R-Car Gen2
 support
Date: Mon, 16 Mar 2020 12:30:56 +0200
Message-ID: <20200316103056.GU4732@pendragon.ideasonboard.com>
References: <20200316101453.27745-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:34952 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgCPKbE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:31:04 -0400
Content-Disposition: inline
In-Reply-To: <20200316101453.27745-1-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 11:14:53AM +0100, Geert Uytterhoeven wrote:
> All R-Car Gen2 SoCs have a Renesas Timer Pulse Unit.
> Document support for the missing variants.
> 
> No driver change is needed due to the fallback compatible string.

I think this sentence doesn't belong to the bindings patch.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Tested on R-Car M2-W.

What do you mean by tested, how do you test bindings on hardware ? :-)

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 4969a954993cb693..4bf62a3d5bba8e3a 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -19,6 +19,10 @@ properties:
>            - renesas,tpu-r8a7744   # RZ/G1N
>            - renesas,tpu-r8a7745   # RZ/G1E
>            - renesas,tpu-r8a7790   # R-Car H2
> +          - renesas,tpu-r8a7791   # R-Car M2-W
> +          - renesas,tpu-r8a7792   # R-Car V2H
> +          - renesas,tpu-r8a7793   # R-Car M2-N
> +          - renesas,tpu-r8a7794   # R-Car E2
>            - renesas,tpu-r8a7795   # R-Car H3
>            - renesas,tpu-r8a7796   # R-Car M3-W
>            - renesas,tpu-r8a77965  # R-Car M3-N

-- 
Regards,

Laurent Pinchart
