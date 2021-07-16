Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDBC636C9
	for <linux-pwm@archiver.kernel.org>; Fri, 16 Jul 2021 01:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1020D613D9
	for <linux-pwm@archiver.kernel.org>; Fri, 16 Jul 2021 01:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhGPBQJ (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232955AbhGPBQI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Jul 2021 21:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A906A613DA;
        Fri, 16 Jul 2021 01:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626397994;
        bh=Yh9NAAkkbQXEI9GYDizGJncAlUS/svmbFXP2sp5d9Zo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gQlrFFZI7JVdrZzRXIWrE0JlWLUKoS18nryBfTiT+0RMci61QcPEJ1gG1oX1XGMKz
         wZHkzn3igimeBzHSC0JvKK5WSTOxezJtN3IS0kD3shYAp9xWJgb5r2Rd/82gwnFi82
         YasRyLYMGLoNj7PDhj44dEtNmwyat92XX5bHpC1x4zMgQfPurHObj3GO/01td8DooJ
         pU82+4Q9f7Z8NT/LQdsjBz1u/k4YPvgMo+35tAqG0cyLXLHjW9rRGTEJarUkfVKiU8
         HCkuVWQEWkM0NpzIx/TOgNbEYOfLYEzLdmP+iP688UgHmJQIB7JeVYm0SV80ei23i1
         5ZnrOwrKy5a4A==
Subject: Re: [GIT PULL] pwm: Fixes for v5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210714074326.89692-1-thierry.reding@gmail.com>
References: <20210714074326.89692-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210714074326.89692-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc2
X-PR-Tracked-Commit-Id: f4a8e31ed84ec646c158824f423cb22d1f362bbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7612872866e2cbfc7ac6c071f35720c70b767ed3
Message-Id: <162639799465.22633.15512969245285609361.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 01:13:14 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Wed, 14 Jul 2021 09:43:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7612872866e2cbfc7ac6c071f35720c70b767ed3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
