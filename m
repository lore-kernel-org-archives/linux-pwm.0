Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0FC77B7E
	for <linux-pwm@archiver.kernel.org>; Thu, 25 May 2023 11:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjEYL2b (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 25 May 2023 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjEYL2a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 May 2023 07:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DEE7;
        Thu, 25 May 2023 04:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36962644E8;
        Thu, 25 May 2023 11:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A968C433D2;
        Thu, 25 May 2023 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685014108;
        bh=80WjExu69YZ2z4Yx+TkUK0wPnz4HeaoTG1bwDpjeRRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlD8ees5bAkKLqFjBq3iW6EmUYXa30dyvHZGzMelEuKFDt3HVxCS7ZhSpNAjfsNrO
         vvnfts2gv5AnkHr+gMbXj2yNp1brxD+qLu3jcIq5xt3Og8KApYozFl8UWN1oDLWi2+
         D4R1yvBvWN+4Yb4KMgJ6hxDiJqv+cY0fht6hV62oPJaCxHNP+uIqwah6ySmb0MeN+Z
         xQxtzcCzQHOSBXrNDTbgViXxAUWA7DWQQKkPiAO/CIIDq9KoBaHuKX0FKRdlOVaX+r
         mllGzWqvSch7UE14Rt/J0r9+XZ+bvQO1gOfOEbgnaTVfmFud2OYhWOmOajqwwdsCRs
         xTXPRsLXo0Zjw==
Date:   Thu, 25 May 2023 12:28:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Remove unneeded checks for valid GPIOs
Message-ID: <20230525112823.GB423913@google.com>
References: <00be8237e0e2bc9b179177b5490f175d657261a2.1684856337.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00be8237e0e2bc9b179177b5490f175d657261a2.1684856337.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 23 May 2023, Geert Uytterhoeven wrote:

> All of gpiod_set_value_cansleep() and gpiod_direction_output() handle
> NULL GPIO pointers just fine, so there is no need to check for that in
> the caller.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
