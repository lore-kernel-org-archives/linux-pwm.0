From: "Zha, Qipeng" <qipeng.zha@intel.com>
Subject: RE: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Fri, 13 Mar 2015 00:51:35 +0000
Message-ID: <C6287702A945AC47BE5DB5DFD4B5C6DD0185D774@SHSMSX104.ccr.corp.intel.com>
References: <1426170508-8273-1-git-send-email-qipeng.zha@intel.com>
 <20150312075835.GC30344@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16097 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbbCMAvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2015 20:51:41 -0400
In-Reply-To: <20150312075835.GC30344@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Westerberg, Mika" <mika.westerberg@intel.com>

Thierry

Thank you very much:)


Best wishes
Qipeng

-----Original Message-----
From: linux-pwm-owner@vger.kernel.org [mailto:linux-pwm-owner@vger.kernel.org] On Behalf Of Thierry Reding
Sent: Thursday, March 12, 2015 3:59 PM
To: Zha, Qipeng
Cc: linux-pwm@vger.kernel.org; Westerberg, Mika
Subject: Re: [PATCH] pwm: update lpss pwm driver to support Broxton platform

On Thu, Mar 12, 2015 at 10:28:28PM +0800, qipeng.zha wrote:
> From: "qipeng.zha" <qipeng.zha@intel.com>
> 
> Add pci device id for Broxton platform.

For reference, this should be "PCI" and "ID", but I can fix those up while applying.

Also, it's customary to include a changelog in subsequent versions of a patch, as well as change the subject prefix to include the patch version number. That makes it easier for other people to track things.

You can do so using:

	$ git format-patch --subject-prefix='PATCH v2' ...

The changelog typically goes below the --- marker (the one below the Signed-off-by line) and would look something like this:

---
Changes in v2:
- keep board information table sorted by device ID
- reuse Braswell board information

Again, no need to resend this time, but something to keep in mind for future patches.

> Signed-off-by: qipeng.zha <qipeng.zha@intel.com>

I'd prefer a proper spelling of your name. Would "Qipeng Zha" be correct?

Thierry
