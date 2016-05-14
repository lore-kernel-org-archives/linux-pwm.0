From: Steven Jackson <sj@oscode.net>
Subject: Re: [PATCH] backlight: =?utf-8?b?cHdtX2JsOg==?= use =?utf-8?b?Z3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVw?= to fix warnings
Date: Sat, 14 May 2016 10:44:30 +0000 (UTC)
Message-ID: <loom.20160514T123857-127@post.gmane.org>
References: <5736F6F0.4020800@oscode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59544 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbcENKuK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sat, 14 May 2016 06:50:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pwm@m.gmane.org>)
	id 1b1X92-0001DT-Cb
	for linux-pwm@vger.kernel.org; Sat, 14 May 2016 12:50:04 +0200
Received: from cpc74487-stre6-2-0-cust124.1-1.cable.virginm.net ([82.22.61.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2016 12:50:04 +0200
Received: from sj by cpc74487-stre6-2-0-cust124.1-1.cable.virginm.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pwm@vger.kernel.org>; Sat, 14 May 2016 12:50:04 +0200
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

Steven Jackson <sj <at> oscode.net> writes:

> +		gpiod_set_value_clansleep(pb->enable_gpio, 1);

Apologies for submitting this stupid typo. There is a v2 patch which fixes
it. The change has been tested on a custom board with an i.MX6.

Regards,
Steven
