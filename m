From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] pwm: lpss: Add support for multiple PWMs
Date: Fri, 6 Nov 2015 11:15:55 +0200
Message-ID: <20151106091555.GW1509@lahna.fi.intel.com>
References: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 20, 2015 at 04:53:05PM +0300, Mika Westerberg wrote:
> New Intel SoCs such as Broxton will have four PWMs per PCI (or ACPI)
> device. Each PWM has 1k of register space allocated from the parent device.
> Add support for this.

Hi Thierry,

Are you going to pick these up to PWM tree?

Thanks.
