Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5AC433E0
	for <linux-pwm@archiver.kernel.org>; Tue, 22 Dec 2020 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A956422D73
	for <linux-pwm@archiver.kernel.org>; Tue, 22 Dec 2020 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgLVRoq (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 22 Dec 2020 12:44:46 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:60688 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgLVRoq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 12:44:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id DBD902418B;
        Tue, 22 Dec 2020 17:44:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OMTNA_qN7MQl; Tue, 22 Dec 2020 17:44:04 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2348624169;
        Tue, 22 Dec 2020 17:43:49 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] pwm: rockchip: Do not start PWMs not already
 running
References: <cover.1608407584.git.simon@simonsouth.net>
        <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
        <ff2bf1bb-e95f-138c-df5a-12ed73568572@arm.com>
Date:   Tue, 22 Dec 2020 12:43:49 -0500
In-Reply-To: <ff2bf1bb-e95f-138c-df5a-12ed73568572@arm.com> (Robin Murphy's
        message of "Tue, 22 Dec 2020 17:23:12 +0000")
Message-ID: <87pn31hh2i.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Robin Murphy <robin.murphy@arm.com> writes:
> Since you're touching it, I guess it might be a good idea to update
> this message to say "PWM clk" for clarity.

Sure, I'll be happy to remove another source of confusion.

-- 
Simon South
simon@simonsouth.net
