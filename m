Return-Path: <SRS0=03ky=BF=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CBC433E0
	for <linux-pwm@archiver.kernel.org>; Sun, 26 Jul 2020 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACBD20578
	for <linux-pwm@archiver.kernel.org>; Sun, 26 Jul 2020 17:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVCxvhIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGZRZm (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGZRZm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 13:25:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487BC0619D2;
        Sun, 26 Jul 2020 10:25:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so14723718ejj.10;
        Sun, 26 Jul 2020 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJ0vbTF+4g0+R92swO8etJBBne94tfH4VmsrcgeyQ58=;
        b=gVCxvhIkJjiwQeygXoc4epeIIgc2pTHisZU5nWDKMc8n3pzt1MqlUwSKYhoq2V9FAl
         kuMKHr5sycwFceCiLic8DEqGcDWxgFW9PCsDnCrZSmu8pthYHrhMNYBeQgzRqJo1tSkv
         v+ecKVqgFi3TPP8XQiwc9XbJ4pfpmS4l1yRsU7FpLNJT6FN1xTWjF1KDFMm+9+kqQ2hV
         CH9YoHEUH4DTUQFJ9d9QbTr6KqJ5pqhakxQGviHOA9xeG0q9/ZUf8PZWdSLAZv/26dJO
         n2ptm6ZEKQUC4b+D1je0ImD2554crr79bDQmineeEF56awk4HQULFnPM3KiOIey/ZeIo
         1ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJ0vbTF+4g0+R92swO8etJBBne94tfH4VmsrcgeyQ58=;
        b=jVmuIz/Sbbrsj5Z52gQ23pnPBNW0fa6I7eNAw9JS+wBkN56zF714iGKmpsqE8c77qE
         AHV7WA2JvnztYf1KIRvZNuCUbyKRmpH5RmS+5AnmFUBdqwtpTpC0bwMGqQLHh8t0+hRu
         BTBdx2B11c7RmRpPrJIAwHzZqfjxf/uHXAMwbvHiO1dzaRe5Erp+xFrmLu6ZHY+wMzhw
         jBgPi6nKRCiwdr/g/2gQLdLiDnCYmdJO2NXM3DCE6OVEPH3dfir9zvn+VVrUbV9unAbV
         H1iQEEfskuJlwndLqzHht+2WWmZkUvEPPskUgE7TuW25vz3o0tGmKAm75CYumhUpXMqG
         v8YA==
X-Gm-Message-State: AOAM531ZhpcpNMzHoDK+FWGaTthuQZnGReUwNQAcXTau5Q51lBZvuNqM
        kXoUWecbA2l9JTN8NyXgQ9OgBC3+t9IjmPJID54=
X-Google-Smtp-Source: ABdhPJxowpPcXLcFxLDm35VpJuOfCSneOz5Et38MjSgxx6/pFEJofelS0ph5MC6O5zP8M7nfjwYi1I5q0m6bYvO1p2U=
X-Received: by 2002:a17:906:50a:: with SMTP id j10mr17387368eja.113.1595784340603;
 Sun, 26 Jul 2020 10:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com> <20200724213659.273599-5-martin.botka1@gmail.com>
In-Reply-To: <20200724213659.273599-5-martin.botka1@gmail.com>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sun, 26 Jul 2020 19:25:03 +0200
Message-ID: <CADQ2G_GY+YH3zFUmqkZZ1sdXPSL_XB5nCgxnwD1zdfNVsJtjfA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] leds: leds-qti-tri-led: Add LED driver for QTI
 TRI_LED module
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello.

This driver has the breath feature of the driver broken as I sent a
slightly modified version of it from when I was testing it.
The proper version will come when i will be sending out V2 which will
be hopefully soon as I'm little busy.

Best regards
Martin
