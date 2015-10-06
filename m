From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: [RFC] pwm: chip_data vs device_data
Date: Tue, 06 Oct 2015 09:20:53 +0200
Message-ID: <56137655.40804@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:33829 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbbJFHVD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 6 Oct 2015 03:21:03 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Olliver Schinagl <oliver@schinagl.nl>

Hey Thierry, list,

While working on something in the pwm framework, I noticed that the void 
*data in the pwm_device struct is called chip_data. Why is it not called 
device_data, since it is the data associated with a PWM device, rather 
then the chip, and on that note, if it really is chip related data (thus 
covering the whole chip, not just the single pwm device) why is there no 
chip_data in pwm_chip?

Again, is this something worth my time to add a device_data and rename 
chip_data?

Olliver
