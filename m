From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
Date: Wed, 18 Jan 2017 12:16:44 +0100
Message-ID: <CA+M3ks4NKApD-FGY9=KGcngA2aaiLop8QFtbVmgz2yeOSo7E=g@mail.gmail.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
 <20170118101628.GG18989@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170118101628.GG18989@ulmo.ba.sec>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alexandre Torgue <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Gerald Baeza <gerald.baeza@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Jonathan Cameron <jic23@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

MjAxNy0wMS0xOCAxMToxNiBHTVQrMDE6MDAgVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5n
QGdtYWlsLmNvbT46Cj4gT24gVGh1LCBKYW4gMDUsIDIwMTcgYXQgMTA6MjU6NDBBTSArMDEwMCwg
QmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6Cj4gWy4uLl0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cHdtL0tjb25maWcgYi9kcml2ZXJzL3B3bS9LY29uZmlnCj4+IGluZGV4IGY5MmRkNDEuLjg4MDM1
YzAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvcHdtL0tjb25maWcKPj4gKysrIGIvZHJpdmVycy9w
d20vS2NvbmZpZwo+PiBAQCAtMzk3LDYgKzM5NywxNSBAQCBjb25maWcgUFdNX1NUSQo+PiAgICAg
ICAgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRo
ZSBtb2R1bGUKPj4gICAgICAgICB3aWxsIGJlIGNhbGxlZCBwd20tc3RpLgo+Pgo+PiArY29uZmln
IFBXTV9TVE0zMgo+PiArICAgICB0cmlzdGF0ZSAiU1RNaWNyb2VsZWN0cm9uaWNzIFNUTTMyIFBX
TSIKPj4gKyAgICAgZGVwZW5kcyBvbiAoQVJDSF9TVE0zMiAmJiBPRiAmJiBNRkRfU1RNMzJfVElN
RVJTKSB8fCBDT01QSUxFX1RFU1QKPgo+IE9uZSBvdGhlciB0aGluZzogaXMgdGhlIGRlcGVuZGVu
Y3kgb24gQVJDSF9TVE0zMiBhbmQgT0YgbmVjZXNzYXJ5IGhlcmU/Cj4gQVJDSF9TVE0zMiBhbmQg
T0YgYXJlIGJvdGggcHVsbGVkIGluIGJ5IE1GRF9TVE0zMl9USU1FUlMuIFRoZSBkZXBlbmRlbmN5
Cj4gaXMgcHJvYmFibHkgZmluZSBmb3IgTUZEX1NUTTMyX1RJTUVSUywgdGhvdWdoIGV2ZW4gdGhl
cmUgJiYgT0Ygc2VlbXMgdG9vCj4gbXVjaCwgc2luY2UgaXQncyBhbHJlYWR5IHB1bGxlZCBpbiB2
aWEgQVJDSF9TVE0zMiAtPiBBUk1fU0lOR0xFX0FSTVY3TQo+IC0+IFVTRV9PRi4KClNhaWQgbGlr
ZSB0aGF0IE1GRF9TVE0zMl9USU1FUlMgaXMgZW5vdWdoIHNvIEkgd2lsbCBrZWVwIHRoaXMgb25l
CgpUaGFua3MKCj4KPiBUaGllcnJ5CgoKCi0tIApCZW5qYW1pbiBHYWlnbmFyZAoKR3JhcGhpYyBT
dHVkeSBHcm91cAoKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBT
b0NzCgpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
