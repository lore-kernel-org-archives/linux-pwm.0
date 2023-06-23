Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3985EB64DD
	for <linux-pwm@archiver.kernel.org>; Fri, 23 Jun 2023 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFWOw3 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFWOwO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:52:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01E270B
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:52:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3113da5260dso717760f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531924; x=1690123924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXwLlxrBAUzKuI6pCJ+2fDeWgsjEELKLXFUuRnypKyk=;
        b=lL3V9W78A5I+aw9IPHzSvGStiXJAcyK9oseBImJHqcTFRIzeFtrcwfhFUccwFveC5c
         FjP1BSQz5miFYAXTiYkGd6tAi9Moho8knYdW3SFQed1qYJ4s8cfDxoNLra1MG39S4HvI
         0LwSlqR0pTl24Oplj4VHsUoAu02hE0loutRZfItmZV1b7sZJjXKfVQ5tcKYu5Ko5Iz6F
         ZocE2keOBUjbGUS0iZhm5uM0qLl+nXZ/aYO+URxV1EgvIFjPky2FdlAAr1YIU4wvgDJv
         XZaSjuAcZvCI34Pqb0BXaaMTlKgUFUApSJtQeZ2GAnwOmaaQ/ZQ34tpiN2c+RPjTX2iQ
         5ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531924; x=1690123924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXwLlxrBAUzKuI6pCJ+2fDeWgsjEELKLXFUuRnypKyk=;
        b=l07lFH0NwWF0+1jNb/YjdGtYeVmK15JVmsoRYm9Db123D3wmtbbHr6mzhU98oO1i/4
         ekrd0FxrXvp96uTkXNlGKuotX/K2Wl6OvelvecGvb+bI9izD5F7e4n/5I8hoVq/ifthi
         o/5FqPgPZhpSCu7Q9WWNr/q9X/tcsv/ssMRJvJw9h2+ZuneWB51rKO/GtxIZ/wuWyGXV
         eaxen5D3IRF6BZSQwebSMMf3TDx2fklVV6Iss54EZDcO4cU0Trt5jX3VD0AW4xfi/G0n
         VpFpSPgw4UwlGPLyKMv8F4SkpollzJtXYjS+WSeQiGJ2wnr3SSqOEsh4xaBfvUlrLQaC
         ltDQ==
X-Gm-Message-State: AC+VfDxn0vi6wInHSb0BbJw9yyb/UZKQ6ryqitvyeAcV3Zdovi8+kYs2
        HGJ/cX9oNRR/rFS3O3pbgws=
X-Google-Smtp-Source: ACHHUZ6RWwb2PgLhUse9ObwH28b6mon0M9IyGD1WXWNOdn3a4hOrfhjWiJrSrcJGR2eg8MTcPhuNaQ==
X-Received: by 2002:a5d:58c7:0:b0:30e:45ac:810e with SMTP id o7-20020a5d58c7000000b0030e45ac810emr16419057wrf.36.1687531923998;
        Fri, 23 Jun 2023 07:52:03 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe38e000000b0030fcf3d75c4sm9846161wrm.45.2023.06.23.07.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:52:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sifive: Simplify using devm_clk_get_prepared()
Date:   Fri, 23 Jun 2023 16:51:41 +0200
Message-ID: <168753171950.1191890.189295159991015143.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230418202102.117658-1-u.kleine-koenig@pengutronix.de>
References: <20230418202102.117658-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Tue, 18 Apr 2023 22:21:02 +0200, Uwe Kleine-König wrote:
> Instead of preparing the clk after it was requested and unpreparing in
> .probe()'s error path and .remove(), use devm_clk_get_prepared() which
> copes for unpreparing automatically.
> 
> 

Applied, thanks!

[1/1] pwm: sifive: Simplify using devm_clk_get_prepared()
      commit: 55e644b840baf7a884a27be81b7582794f54a808

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
