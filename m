Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA9C6FD1D
	for <linux-pwm@archiver.kernel.org>; Tue, 21 Mar 2023 11:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCULq2 (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCULqJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Mar 2023 07:46:09 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC04AD22;
        Tue, 21 Mar 2023 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BaVu1ranY6IZPO5w8T3/AsoEgjpGKi9wefT7ScLRJzA=;
  b=o4qCyQ4rHz0HLQOMuw4m39RYMAtYSRZb8iuaciFdXgRTUtZTdFHRfgS/
   i1VstiE4iqZZPpF4+iWQv7brhOTXObHvgxd8eZNKJJraZz5wQugsVzKgC
   8vLlcs2rIq7PDZl7Tq+YBKgjG7I891md9gtQXBqkwIG+wJqGMgt0U7hpd
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="98275290"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 12:46:01 +0100
Date:   Tue, 21 Mar 2023 12:46:01 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/3] edits in greybus driver
In-Reply-To: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
Message-ID: <ee77a227-13bd-70ad-1d8e-f9719970e0f8@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On Tue, 21 Mar 2023, Menna Mahmoud wrote:

> This patchset includes change happened in greybus driver in three
> different files two of them patch one and three related to
> checkpatch issue and in second patch convert two
> `container_of` macros into inline functions.
>
> Menna Mahmoud (3):
>   staging: greybus: remove unnecessary blank line
>   staging: greybus: use inline function for macros
>   staging: greybus: remove unnecessary blank line

Different patches should have different subject lines.  You need to either
be more specific about the file affected or merge the two patches with the
same subject into one.

julia

>
>  drivers/staging/greybus/gbphy.h                  | 10 ++++++++--
>  drivers/staging/greybus/greybus_authentication.h |  1 -
>  drivers/staging/greybus/pwm.c                    |  1 -
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>
>
>
