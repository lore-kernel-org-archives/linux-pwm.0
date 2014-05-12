From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm: lpss: remove dependency on clk framework
Date: Mon, 12 May 2014 10:09:11 +0300
Message-ID: <20140512070911.GW3722@lahna.fi.intel.com>
References: <1399624521-26175-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3416 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111AbaELI27 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 May 2014 04:28:59 -0400
Content-Disposition: inline
In-Reply-To: <1399624521-26175-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, Chew Chiau Ee <chiau.ee.chew@intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 09, 2014 at 11:35:21AM +0300, Heikki Krogerus wrote:
> Unlike other Intel LPSS devices, the PWM does not have the
> clock dividers or the gate. All we get from the clock is the
> rate. Since PCI case uses the driver data to get the rate,
> we can drop the clk and use the same data also in case of
> ACPI. The frequency is the same.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

No objections from me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
