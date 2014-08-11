From: Kamil Debski <k.debski@samsung.com>
Subject: pwm drivers suspend/resume behaviour question
Date: Mon, 11 Aug 2014 12:36:22 +0200
Message-ID: <108f01cfb550$1889aa00$499cfe00$%debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51005 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbaHKKg2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Aug 2014 06:36:28 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NA50016V1GHSBA0@mailout1.w1.samsung.com> for
 linux-pwm@vger.kernel.org; Mon, 11 Aug 2014 11:36:17 +0100 (BST)
Content-language: pl
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Tomasz Figa <t.figa@samsung.com>

Hi, 

I would like to ask a question regarding the intended suspend/resume
behaviour of pwm framework drivers.

Should the period, the duty cycle and enabled state be preserved on suspend
and restored on resume? I don't think this is mentioned in the
documentation.

The pwm-samsung.c driver does not save the period and duty cycle on
suspend/resume.

On the other hand pwm-tiehrpwm.c saves and restores the context on
suspend/resume.

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland



