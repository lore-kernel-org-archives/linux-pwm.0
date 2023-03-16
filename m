Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A14C6FD1F
	for <linux-pwm@archiver.kernel.org>; Thu, 16 Mar 2023 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCPNva (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCPNva (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Mar 2023 09:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B710AF6AD;
        Thu, 16 Mar 2023 06:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3675862018;
        Thu, 16 Mar 2023 13:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC016C433D2;
        Thu, 16 Mar 2023 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974676;
        bh=GKMOZkwRhkwO4hhXO1753J3aDhOKMxlPzOi8m0NOY1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGSy+oIBY5KiJiItId6IIOS1h39A6HcA2LYrNnFVq+SI2QbozAqoYwW3kOQJNsWYs
         Tj0R8MJ0dlaRNXoHuL4mQZtE1O6zIwCdeJ0HsAXzQR4xR7akYG6ydtryIwVGCmU7Ug
         LUgRFImWA3dvJT3GW1Q292DfR65JN3aYBKJ2QQGzcSDH+1RL3XhK5jWmEHafzrlZjJ
         eDBdjEpFDORmPOfdGgMgvZQQrcOeXvHXHYAV8yiQ4bIEiGv2ocvptEkfgPPudyC2pS
         tPmONTnPfqLY/zH7QmKzfh/nsTJucj3ygZ/1ajyxc2mnoxJjeFoX66TXq+X97M+55r
         TVmB87XhzwOzw==
Date:   Thu, 16 Mar 2023 13:51:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 10/13] backlight: pwm_bl: Convert to platform remove
 callback returning void
Message-ID: <20230316135111.GY9667@google.com>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
 <20230308073945.2336302-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308073945.2336302-11-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 08 Mar 2023, Uwe Kleine-König wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
