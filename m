From: David Lechner <david@lechnology.com>
Subject: question about pwm-tiecap driver pwm_disable behavior
Date: Mon, 3 Oct 2016 16:09:35 -0500
Message-ID: <39a472c0-ba24-de7b-8783-a16a71b172cd@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:33359 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbcJCV6W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Oct 2016 17:58:22 -0400
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42208 helo=[192.168.0.113])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <david@lechnology.com>)
        id 1brAU8-0010Xk-6x
        for linux-pwm@vger.kernel.org; Mon, 03 Oct 2016 17:09:16 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

In drivers/pwm/pwm-tiecap.c, there is the following function for 
disabling the pwm.

static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
{
	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
	unsigned int reg_val;

	/*
	 * Disable 'Free run Time stamp counter mode' to stop counter
	 * and 'APWM mode' to put APWM output to low
	 */
	reg_val = readw(pc->mmio_base + ECCTL2);
	reg_val &= ~(ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE);
	writew(reg_val, pc->mmio_base + ECCTL2);

	/* Disable clock on PWM disable */
	pm_runtime_put_sync(pc->chip.dev);
}


I am using this with the pwm-backlight driver to control the backlight 
of a display. When you tell the pwm-backlight driver to use a brightness 
of 0, it disables the pwm.

What I would like to happen is, as the comment says, for the output to 
go low. However, what actually happens is that the output becomes and 
input (and therefore goes high because of an external pullup resisitor). 
This happens because by turning off the ECCTL2_APWM_MODE bit, the PWM is 
switched back to ECAP mode, which acts as an input.

So the question is: Is the comment correct and there is a bug in the 
code, or is the code correct and the comment should be changed?
