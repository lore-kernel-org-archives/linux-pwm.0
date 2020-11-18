Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E65AC5519F
	for <linux-pwm@archiver.kernel.org>; Wed, 18 Nov 2020 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D056221FC
	for <linux-pwm@archiver.kernel.org>; Wed, 18 Nov 2020 09:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKRJuz (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:50:55 -0500
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:45286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgKRJuz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:50:55 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 04:50:55 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id ADAA418033F5D;
        Wed, 18 Nov 2020 09:41:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9A220837F24D;
        Wed, 18 Nov 2020 09:41:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sun17_590424827339
X-Filterd-Recvd-Size: 1850
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 09:41:33 +0000 (UTC)
Message-ID: <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
Subject: Re: [PATCH] pwm: core: Use octal permission
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Soham Biswas <sohambiswas41@gmail.com>, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 01:41:31 -0800
In-Reply-To: <20201118093506.srljfosnamxe5wwz@pengutronix.de>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
         <20201117181214.GK1869941@dell>
         <CAMmt7eO5te05AuVC+MR-zLB-z+r9FCuJwtON=1QXXY2YwQG0eg@mail.gmail.com>
         <20201118085113.GO1869941@dell>
         <20201118093506.srljfosnamxe5wwz@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2020-11-18 at 10:35 +0100, Uwe Kleine-König wrote:

> Actually I'd prefer keeping the symbolic name because this is easier to
> grep for. So to convince me a better reason than "checkpatch says so" is
> needed.

https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
-------------------------------------------------------------------
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Aug 2016 16:58:29 -0400

The symbolic names are good for the *other* bits (ie sticky bit, and
the inode mode _type_ numbers etc), but for the permission bits, the
symbolic names are just insane crap. Nobody sane should ever use them.
Not in the kernel, not in user space.

           Linus


