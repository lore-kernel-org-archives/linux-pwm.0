From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] pwm: lpss: Bug-fix + 2 improvements
Date: Mon, 20 Feb 2017 21:16:54 +0100
Message-ID: <20170220201657.24801-1-hdegoede@redhat.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdBTURB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Feb 2017 15:17:01 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

Hi Thierry,

Here are 3 pwm-lpss patches, note the first one is a bug /
regression fix and should be applied to 4.11 as it fixes a bug
in your current for-next branch.

Regards,

Hans
