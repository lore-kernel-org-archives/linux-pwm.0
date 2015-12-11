From: "Zha, Qipeng" <qipeng.zha@intel.com>
Subject: RE: [PATCH v5] pwm:lpss: update pwm setting for Broxton
Date: Fri, 11 Dec 2015 06:51:38 +0000
Message-ID: <C6287702A945AC47BE5DB5DFD4B5C6DD03833AF6@SHSMSX104.ccr.corp.intel.com>
References: <1447752015-55339-1-git-send-email-qipeng.zha@intel.com>
 <20151117075214.GD1604@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7061 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbbLKGvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2015 01:51:49 -0500
In-Reply-To: <20151117075214.GD1604@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Westerberg, Mika" <mika.westerberg@intel.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>

>> For Broxton PWM controller, base unit is defined as 8bit integer and 
>> 14bit fraction, so need to update base unit setting to output wave 
>> with right frequency.
>> 
>> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

>My ack still applies to this patch.
 Hi Thierry, are you going to apply this patch, thanks.
