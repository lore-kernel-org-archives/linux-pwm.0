Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CFC433F5
	for <linux-pwm@archiver.kernel.org>; Wed, 23 Feb 2022 09:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiBWJQe (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 23 Feb 2022 04:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiBWJQd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 04:16:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173BA811BD
        for <linux-pwm@vger.kernel.org>; Wed, 23 Feb 2022 01:16:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so620655wmb.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Feb 2022 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZUexAi7XZpt/IXnr6iWEdkKC6eoohAZnCV7GkbV1MDk=;
        b=UPs30jYkSROqMLjG9j1ccaDvuvFBZ5GNgJvTkAHoPWEguU9vkan3wlqp8w4RRC+sNC
         d6HpX1ZOmhxyb28eXxfPplk+OaEdgK7CK1LlCHbScbnKriOWRk9o0nkk8CQL+j3M8rIz
         uHYHshSSLKD9qppDHOPTFPQo1j2TB4mGO6JJt26ND9E5k+LQJNTi3Unm4yssGvV8rK6F
         csNHqtqJuoSDtXq/kTvRq/JNzMut6/oIOrWqxA9Q1fFh92hTdcaLmwyedYdGhRCd/nC8
         Pi6oTFPTmPvKaXDd5PQ2t8SSGOPBjkBgPW7AROQg92nxlhgTUSXDbHq6ozZVhTRGR6WO
         yPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZUexAi7XZpt/IXnr6iWEdkKC6eoohAZnCV7GkbV1MDk=;
        b=AK0XopXLKpGf5/JxMasfzr26s2j7xEKgYnM7jTo7CJimTJt8RLwTwpC9ZPql6pxCD1
         qunAtIJ7ODK+WcHEodzI9OOPe8f5JKUNK3mASwoC9t/y1nVhA6V942qSHDp7VSZ5RT/P
         8ZhYcLy3D1i8olTqidU+g7qHh4mteyjU/RhVCG4nDMQ2MLEniZzClaB6Wq+ZBIjdc0Wc
         X3VnbV1k2qnStuZNwq7vc7DI/GchhmiHvARjZesn1Hj+hObBTHE1Ie3kKeJscslrKxH+
         P2HtX62RswR/DnayrAgoHevSSVHlE1/0se0wvd9wQfj0p/F3ytDjxZS2cLtqd++sYLGT
         FP4Q==
X-Gm-Message-State: AOAM533342Xm0s7FCPf/OZrcLop56AnTTgZFLiuVoQdKWCdKAtHZtWpF
        yKT9vgnY6m0qjot2y1lj3Pzvsw==
X-Google-Smtp-Source: ABdhPJwE97ajBq4XbB7MA2j4GjW5Zdm1JD/pIlevtg+JNehqxG7yZMbVnQQYKJW2cgh7nNAlFO7JGg==
X-Received: by 2002:a05:600c:cf:b0:380:f85a:1cd8 with SMTP id u15-20020a05600c00cf00b00380f85a1cd8mr1239350wmm.1.1645607764646;
        Wed, 23 Feb 2022 01:16:04 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m5sm2565403wrb.13.2022.02.23.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:16:04 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:16:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic
 pwm schema
Message-ID: <YhX7UZSDaqNyD1rV@google.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 14 Feb 2022, Krzysztof Kozlowski wrote:

> Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> the old name in bindings as deprecated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml          | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
