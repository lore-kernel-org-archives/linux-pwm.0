Return-Path: <SRS0=HNCL=B3=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B30EC433E3
	for <linux-pwm@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037B420674
	for <linux-pwm@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693116;
	bh=uL3CiGQO5lTVSg6FRgGW4wao8mfJKlmO0zjEjw/6SII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CuSLH11b8udrK6XOWoVPR+ltiFKkgl9G7HeOus/hHfCROPPM5qxgHEvudg9XpA3zz
	 C2+OtGFOudBjoWOo3KRl2tQoxe8M6mzyd60geq4KA2DnhuNrtMB8eJQkrvUpiKDHFU
	 OzYqAYfqR/tzWjq8EOgXujYKq9uksrguvy1MPiVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHQTid (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:38:33 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44800 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbgHQTi2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2020 15:38:28 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so15538877ilc.11;
        Mon, 17 Aug 2020 12:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Flz5BKGDdaW7ZnqIwZRWx/uMxnDaWlXWl56bHuuN1CU=;
        b=F77oA9uRN2ZBXSOMCXwOZfPt2qyAcUn63ashmvDVoj9j79iFdbowL+5F0c4G4JDshn
         3qDIxlTx3n5yPYgVFhWzR2FQ/OEEJpCtrKp1GWQ1ezY1+tkBbMWwdhZplD+AnF4FA5aq
         /lYWbh8NzAfOMeHnyS/lCupXpcfMnzwKXp1fntrgiV2+7sqI604lq0J4zIV8zQp1WeJ9
         vXd40jeQDErZ06JkC9L8qDpdntKH+rgCsgI8Z5S7/qYtP6YfOouLYOUtGkUJZnA55QDr
         j2g/OzOr8VspgplD+wEMPkv2dUnAV2GwtcstLYDq3ht74bYZTc0XbYDEpksdDCGg3X+6
         3LyQ==
X-Gm-Message-State: AOAM533wu8kPQ9doz8KjmsyU8kyqJ2Zr/4FQQaIH7rR6lp4OmPIshyUS
        YQmN7qkaPWBgCa+dgS36GA==
X-Google-Smtp-Source: ABdhPJzCXtRI+ilbmlVB/zkPF+w3d3j6oztJQTv8tmf6mi11GZPzY/jlYGFb8HwqGgx8EQdWfkx2bA==
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr15171197ilq.42.1597693107034;
        Mon, 17 Aug 2020 12:38:27 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w22sm9520191ioc.24.2020.08.17.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:38:26 -0700 (PDT)
Received: (nullmailer pid 1419503 invoked by uid 1000);
        Mon, 17 Aug 2020 19:38:25 -0000
Date:   Mon, 17 Aug 2020 13:38:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, kernel@axis.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, oliver@schinagl.nl
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20200817193825.GA1416132@bogus>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814155513.31936-1-vincent.whitchurch@axis.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 14, 2020 at 05:55:12PM +0200, Vincent Whitchurch wrote:
> Add bindings for the pwm-gpio driver.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> new file mode 100644
> index 000000000000..51941cd03955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO-based PWM
> +
> +maintainers:
> +  - Vincent Whitchurch <vincent.whitchurch@axis.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pwm-gpio
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  gpio:

'gpios' is the preferred form even if singular.

> +    maxItems: 1
> +    description: GPIO to toggle.
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +  - gpio
> +
> +additionalProperties: false
> -- 
> 2.25.1
> 
