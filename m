Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB8C433DB
	for <linux-pwm@archiver.kernel.org>; Mon, 29 Mar 2021 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0CB6192C
	for <linux-pwm@archiver.kernel.org>; Mon, 29 Mar 2021 17:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2RRK (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 29 Mar 2021 13:17:10 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57336 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhC2RQl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Mar 2021 13:16:41 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id E4351C729F1;
        Mon, 29 Mar 2021 19:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617038200;
        bh=mwT830ZmSukqqo+1KfIIOfyi/WJMzx76Bo76wcInTPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxQYwlPA3PQdqhvLvP9MabX+IpfSQDQA4W2Ik0rmR4jgdHerxRX+sqU4l2Q9bgBLJ
         +N+qvkuNGy7to7v+oBsvcPTQ26TWAWI6x02G2VNY5fk/VE79mpHyqIqRX7NUI3IRpZ
         9mbTOIRXo0N9fzcIaNImJnNNw0wAl3FQMJGuAu/s=
Date:   Mon, 29 Mar 2021 19:16:38 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <YGILdjZBCc2vVlRd@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329170357.par7c3izvtmtovlj@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-König wrote:
> On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > The PCA9685 supports staggered LED output ON times to minimize current
> > surges and reduce EMI.
> > When this new option is enabled, the ON times of each channel are
> > delayed by channel number x counter range / 16, which avoids asserting
> > all enabled outputs at the same counter value while still maintaining
> > the configured duty cycle of each output.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> 
> Is there a reason to not want this staggered output? If it never hurts I
> suggest to always stagger and drop the dt property.

There might be applications where you want multiple outputs to assert at
the same time / to be synchronized.
With staggered outputs mode always enabled, this would no longer be
possible as they are spread out according to their channel number.

Not sure how often that usecase is required, but just enforcing the
staggered mode by default sounds risky to me.

Thanks,
Clemens
