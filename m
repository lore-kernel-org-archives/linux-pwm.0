From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Date: Tue, 5 Nov 2019 22:16:08 -0600
Message-ID: <20191106041608.GA24747@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-2-benjamin.gaignard@st.com>
 <20191106041023.GB5294@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191106041023.GB5294@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 10:10:23PM -0600, Rob Herring wrote:
> On Thu, Oct 31, 2019 at 01:30:37PM +0100, Benjamin Gaignard wrote:
> > Convert the STM32 counter binding to DT schema format using json-schema
> 
> Probably this should all be 1 file instead.

Also, checkpatch reports trailing whitespace in several of your patches.

Rob
