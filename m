Return-Path: <SRS0=p4Yd=D5=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34756C388F7
	for <linux-pwm@archiver.kernel.org>; Thu, 22 Oct 2020 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD68F24682
	for <linux-pwm@archiver.kernel.org>; Thu, 22 Oct 2020 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603397416;
	bh=js1xVi8azsx4//F3LDMoMhOlgktwnKS5gIAhVHl2EFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7JcxqtrN9OpOj2NoK5mBmReHwv3KyBdFirNALxNRHXzpNK1CyBcthTRW1sqDIUzn
	 aNn5adwDpMMgsjermnZFKOsdXASxUlN/OTuKAOuUOPaxQUhR4b66196EeVM3mzN4jH
	 Ch6hzpUZNqq02HwS/2O3F/wOW3qloenzT8V7ztgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897310AbgJVUJd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:09:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39785 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502779AbgJVUJa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 16:09:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id y12so4697084wrp.6;
        Thu, 22 Oct 2020 13:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pG/K91KXSZtDns2AvPosts1iq0wuPSbXqFIa1nMAu2w=;
        b=N6WfAfaXGeTqPKErIbTwDhPl3VBZvktGZ/Xksp+FXeJP16OXkSTEyqZ7Npp8Mdnae8
         s3b8rmu6w+BxuTiA5Bi4gSAyatg629Jb99VIMPb/37228LUC1A5AP7BoEHcTOhJK/njA
         RNWmKEJ5Pz8mEiR0XMhGoapwU5sif+GjaW9ZSDncvtuTguIkxp2ka3I/nFDULrIrNFHE
         hVxciUT5KjemIzJgVjzQExyH5fULRkO1ULN3bxlzMU9v082xIvSvvfdBmtOt8jUdD5eX
         Fd3F8HBRuP1Ehxcxoj4mbWRWDWqn5HaFAYGkEqRktOEBJa0fg3sfJlj3PQdY2p9LP7AB
         EeWQ==
X-Gm-Message-State: AOAM530Za/PZw2ktAZxrhXM7xC3/uP/6jmryUgu8UDMyFV69ZJ4KBeUG
        A0+RrVaIL0oFwRR39XrUzOo=
X-Google-Smtp-Source: ABdhPJzUGE+RlNXwy0g9TwXZfxBn1ZcK5RdACIJ17IaoA7fVJ337UFCiXYdwy0tV3Mwcv7KXKaZwHw==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr4350348wrl.325.1603397368769;
        Thu, 22 Oct 2020 13:09:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id c18sm5874798wrq.5.2020.10.22.13.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:09:27 -0700 (PDT)
Date:   Thu, 22 Oct 2020 22:09:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Kamil Debski <kamil@wypas.org>
Subject: Re: [PATCH 1/4] MAINTAINERS: move Kamil Debski to credits
Message-ID: <20201022200925.GA2525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
 <20201022191314.plesyizmczgdmodr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201022191314.plesyizmczgdmodr@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 22, 2020 at 09:13:14PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> this series doesn't seem to be applied and looking at the list of people
> this mail was sent "To:" it's not obvious who is expected to take it. I
> assume it is not for us linux-pwm guys and will tag it as
> "not-applicable" in our patchwork.

Hi Uwe,

All of the patches, including the one here, touch actually multiple
subsystems, so if this is OK with you, I could take them through
Samsung SoC.

Best regards,
Krzysztof

