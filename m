From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/5] pwms: pwm-ti*: Remove support for local clock
 gating
Date: Wed, 2 Mar 2016 14:54:13 -0800
Message-ID: <20160302225413.GF4469@atomide.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-2-git-send-email-fcooper@ti.com>
 <20160229220444.GQ13417@atomide.com>
 <56D4C69D.1090100@ti.com>
 <20160229225536.GR13417@atomide.com>
 <56D4D032.7040801@ti.com>
 <20160229232011.GU13417@atomide.com>
 <56D741E6.3000708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:47881 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcCBWyS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 2 Mar 2016 17:54:18 -0500
Content-Disposition: inline
In-Reply-To: <56D741E6.3000708@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: paul@pwsan.com, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

* Franklin S Cooper Jr. <fcooper@ti.com> [160302 11:41]:
> I know there are some comments regarding other patches in
> this patchset but this patch is unrelated and can be pulled
> in separately. Any objections to this or should I just
> resubmit this patch by itself?

No objections from me at least. If something needs to
change at the driver level, it sounds like a different
set of patches then.

Regards,

Tony
