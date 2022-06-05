Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E397C43334
	for <linux-pwm@archiver.kernel.org>; Sun,  5 Jun 2022 21:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348717AbiFEVaD (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sun, 5 Jun 2022 17:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbiFEV35 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 5 Jun 2022 17:29:57 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0BF4CD58;
        Sun,  5 Jun 2022 14:29:56 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id k4so2668385qth.8;
        Sun, 05 Jun 2022 14:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WJ/cPPuCGEcGJe5vuLwdlkfztZsLYNQcfy21FejcMY=;
        b=V7HPbeWM1splsWssW1lc7BuZxXyuYYS1Xx4XRd6tuO7IfDbTf5HeXyaiMEHjP1cNt/
         zr98v+AG68H0L2zD/TJmcG/18qST/+bh0RWoPf5Ae0z8ETO4k3EE/iXCldPL+8yQMa6A
         Z4MrRHcc7RBK3pxeN1rbyIATORcHuC8iP4jg7zri+XBOTuQyDupKCgutfT9M/imma1Md
         P36xdgikxCCe9QyzDk09rQ899daqABCciRY+R7UXgXANA3yIDCsAB8aIoQ4qUdRxKQSf
         YEY/+ckPyYNlTgfgF/qaFXkRaTkxL6LAhWmu9J7cQ11xlmYYbzuIqVPoDe0O6M1M/GRw
         1vqg==
X-Gm-Message-State: AOAM531/pIFvwCXKMP820H/gcrz4W3oaOJU6XyvnS72VoeUzpZ6QNvgX
        Dndmx9gVvJmTknzykePDbG8v9LVqCA==
X-Google-Smtp-Source: ABdhPJyHi6eBGQ+GxgFnFyx3TIgsB59Q5okv0AgtRq4h1nbNXXkD4Zyg153WflRQW6zPHqhaFp001w==
X-Received: by 2002:a05:622a:1820:b0:303:b8ef:b564 with SMTP id t32-20020a05622a182000b00303b8efb564mr16441196qtc.319.1654464595562;
        Sun, 05 Jun 2022 14:29:55 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a268f00b006a3af1bd183sm9008320qkp.127.2022.06.05.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:29:55 -0700 (PDT)
Received: (nullmailer pid 3551819 invoked by uid 1000);
        Sun, 05 Jun 2022 21:29:52 -0000
Date:   Sun, 5 Jun 2022 16:29:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek: add pwm binding for
 MT8195
Message-ID: <20220605212952.GA3551762-robh@kernel.org>
References: <20220531114544.144785-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531114544.144785-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 31 May 2022 13:45:43 +0200, Fabien Parent wrote:
> MT8195's PWM IP is compatible with the MT8183 PWM IP.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
