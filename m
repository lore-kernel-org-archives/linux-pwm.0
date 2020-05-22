From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v13 11/11] pwm: core: Convert period and duty cycle to u64
Date: Fri, 22 May 2020 15:26:31 +0200
Message-ID: <20200522132631.sazoyq2d3krdvg6o@pengutronix.de>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <0ff7cc052b38411cba050d7066f17c9062a9101a.1587523702.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgEVN0l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 May 2020 09:26:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F928C061A0E
        for <linux-pwm@vger.kernel.org>; Fri, 22 May 2020 06:26:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0ff7cc052b38411cba050d7066f17c9062a9101a.1587523702.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Joe Perches <joe@perches.com>

On Tue, Apr 21, 2020 at 07:57:23PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 in the structs of the
> PWM framework so that higher durations may be set.
> 
> Also use the right format specifiers in debug prints in both core.c as
> well as pwm-stm32-lp.c.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Joe Perches <joe@perches.com>
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>

I like this change in general. I didn't check all the prepatory patches
in detail but the few I glanced over looked ok.

I think we have to prepare for having to fix a few fallouts but consider
it ok to expose this in next (but wouldn't send it for 5.8-rc1 yet).

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
