Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A1C433EF
	for <linux-pwm@archiver.kernel.org>; Mon,  6 Sep 2021 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E027360E76
	for <linux-pwm@archiver.kernel.org>; Mon,  6 Sep 2021 09:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbhIFJrr (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 6 Sep 2021 05:47:47 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:33299 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbhIFJrr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Sep 2021 05:47:47 -0400
Received: by mail-vs1-f43.google.com with SMTP id bf15so5125056vsb.0;
        Mon, 06 Sep 2021 02:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eP47cThoI0VvsvJ5AGPC4PuJ4KfItGd565M9Gb4OlkA=;
        b=RwsS43FnHxmm1bNFr3oQJeiQxNCXqzvMcTibBGs9tsSNB3lomnmLn+fTDoeGFrQwo5
         sXKPCTbqcfkwIZeNdteo6qyXWhKtsG/d5VSFYtxV4BeF8LRh+T8HhlD1AN/ygJBKrZ24
         hIWkOcVQ+/837R8Gqsclakt4HNR0n7V+H++UhcNJSPKmNc9PUAXuxppKvvbH3gW7Vze+
         FpIgMAmBV64KHxQVS0h2Lafn1uLYH7BdduDFaJIp9A7UWVICogCyYuJ/nDkTnquaFARb
         3IVgLoB2e3pEs+or5xpmWng1RyK140z6ixmwBJOp1/H+8T4nlbjCQ3bQRwQkbJfDOaxu
         WNCg==
X-Gm-Message-State: AOAM532badauMIeJUIVhnLWCb3RLZOf1JV6/BxvgENGdidlDzOayFzwJ
        XMcdynHmb8tlmaL61BLLX8j5KudDcibSxk/VFpI=
X-Google-Smtp-Source: ABdhPJywRAAdBqfsJnq+czYUAv4oOeJjEmj0n0UccZ8k/mTQqF2Fmyp6AMZUBqSkZaQNe98oGUYRcYjTNpVqhXQoqIw=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr5147711vsl.9.1630921602323;
 Mon, 06 Sep 2021 02:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Sep 2021 11:46:31 +0200
Message-ID: <CAMuHMdVYuXswW1FqAD+v_PEGUX0pJ0xZRi3MH9KVHJRo1B9fog@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree bindings
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 6, 2021 at 11:45 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
