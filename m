Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C63C35273
	for <linux-pwm@archiver.kernel.org>; Sat, 19 Dec 2020 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56D123DE7
	for <linux-pwm@archiver.kernel.org>; Sat, 19 Dec 2020 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgLSVHY (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 19 Dec 2020 16:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLSVHU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:20 -0500
Subject: Re: [GIT PULL] pwm: Changes for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412000;
        bh=KLg2cKySGiiS/TfxsYaRABdXT+o88LG050RgYe211h8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rRzLK4Fma4udmbwD4u5JJNC15C2KZoIzVojHECXG9DirQXJFxy6kdjnb445gEhq0T
         FJ3iSwpIreXQRwzbhlLrtp4Ml+3cngJTlZPOwu7WfajFntxW7xpDKPWKNAAjGxBu7q
         205N60maaMeHzqz+propXYwWYrb++7dIVJX0iJ0u54F4vtaswQtRvdcwiowJlG02br
         U1KiuWPp0+UYs5ZWv2MNzFJvky3uA3XibDSp7alRnMgq9RLlbR2SlBefuhN0urKBcS
         IcwRANjnZuI9JsgDZFJp0haZ1z91bertO2LGE69PrWjy9jtBOsTys6kKeQNKzThQTe
         5BP9D/QDQ7cWw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218160401.2478999-1-thierry.reding@gmail.com>
References: <20201218160401.2478999-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218160401.2478999-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.11-rc1
X-PR-Tracked-Commit-Id: 6eefb79d6f5bc4086bd02c76f1072dd4a8d9d9f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d56154c7e8ba090126a5a2cb76098628bc2216a2
Message-Id: <160841200042.20285.2500639931783873174.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:40 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 17:04:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d56154c7e8ba090126a5a2cb76098628bc2216a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
