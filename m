From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] pwm_lpss: Add support for PCI devices
Date: Tue, 22 Apr 2014 14:46:18 +0300
Message-ID: <20140422114618.GN30677@intel.com>
References: <1397819860-22213-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45751 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147AbaDVLin (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 22 Apr 2014 07:38:43 -0400
Content-Disposition: inline
In-Reply-To: <1397819860-22213-1-git-send-email-chiau.ee.chew@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Chew Chiau Ee <chiau.ee.chew@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 18, 2014 at 07:17:40PM +0800, Chew Chiau Ee wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Not all systems enumerate the PWM devices via ACPI. They can also be exposed
> via the PCI interface.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
