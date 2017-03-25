From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before waiting for update-bit
Date: Sat, 25 Mar 2017 15:06:57 +0100
Message-ID: <20170325140658.26868-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdCYOHB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 25 Mar 2017 10:07:01 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

Hi Andy, Thierry,

This patch fixes a regression with the pwm-lpss driver in 4.11,
where it once turned off will not turn back on again on some
machines. Yet it has been silent around this patch for some
time now. Can you please review this and get it queued as a fix
for 4.11 ?

Regards,

Hans
