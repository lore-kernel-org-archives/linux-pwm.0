From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: mtk_disp: implement .apply()
Date: Sun, 24 May 2020 19:44:34 +0200
Message-ID: <20200524174434.tcnszokabt2ymh7x@pengutronix.de>
References: <20200410031955.111392-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387737AbgEXRoo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:44:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F3C061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 10:44:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200410031955.111392-1-jitao.shi@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com

Hello,

On Fri, Apr 10, 2020 at 11:19:55AM +0800, Jitao Shi wrote:
> implement the apply() for pwm.
> 
> Fix the clock clk_prepare_enable and clk_disable_unprepare mismatch,
> switch the driver to support the ->apply() method.

Adding support for get_state is a separate change.

Other than that this patch looks more complicated that I would expect,
I think you can make this easier to understand/review by moving the
mismatch to a separate patch, too.

Can you please respin with these hints in mind, then I'm willing to
invest some time for a deeper review. In general it's very welcome to
convert the mtk-disp driver to the atomic API. Thanks for addressing
that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
