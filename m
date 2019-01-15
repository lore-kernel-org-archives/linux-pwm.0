From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 15 Jan 2019 07:27:57 -0800
Message-ID: <20190115152757.GB26443@infradead.org>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, sachin.ghadi@sifive.com, thierry.reding@gmail.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

From a general code quality point of view this looks fine to me.
I don't really know anything about the PWM subsystem, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
