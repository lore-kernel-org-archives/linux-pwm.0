From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg'
 warning
Date: Wed, 15 Apr 2020 21:29:28 +0200
Message-ID: <20200415192928.tjmh2m6a63lmnp3b@pengutronix.de>
References: <20200415182639.18534-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437032AbgDOT3g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 15:29:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B49C061A10
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2020 12:29:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200415182639.18534-1-robh@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org

Hello Rob,

On Wed, Apr 15, 2020 at 01:26:39PM -0500, Rob Herring wrote:
> The example for the CrOS EC PWM is incomplete and now generates a dtc
> warning:
> 
> Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17.11-23.11:
> Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg or ranges property
> 
> Fixing this results in more warnings as a parent spi node is needed as
> well.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> index 24c217b76580..41ece1d85315 100644
> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> @@ -31,10 +31,17 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    cros-ec@0 {
> -        compatible = "google,cros-ec-spi";
> -        cros_ec_pwm: ec-pwm {
> -            compatible = "google,cros-ec-pwm";
> -            #pwm-cells = <1>;
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cros-ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            reg = <0>;
> +
> +            cros_ec_pwm: ec-pwm {
> +                compatible = "google,cros-ec-pwm";
> +                #pwm-cells = <1>;
> +            };

Looks reasonable

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Is this supposed to go via the pwm tree, or do you apply yourself via a
device-tree tree?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
